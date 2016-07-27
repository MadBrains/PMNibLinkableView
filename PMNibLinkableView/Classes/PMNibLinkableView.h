//
//  PMNibLinkableView.h
//  MyDreams
//
//  Created by Anatoliy Peshkov on 21/06/2016.
//  Copyright © 2016 Perpetuum Mobile lab. All rights reserved.
//

#import <UIKit/UIKit.h>

// Gives view described in separate xib ability to be loaded in other xib or storyboard without creating it manually in code
// If view has children in super xib or storyboard, "tag" should be set to 999
// http://merowing.info/2012/12/quick-tip-for-interface-builder/

@interface PMNibLinkableView : UIView

@end
